package fz;

import java.util.Enumeration;
import java.util.Vector;

public class UserList
{
  private Vector container;
  private static UserList instance = new UserList();

  private UserList()
  {
    this.container = new Vector();
  }

  public static UserList getInstance()
  {
    return instance;
  }

  public void addUser(String user)
  {
    if (user != null)
      this.container.addElement(user);
  }

  public Enumeration getList()
  {
    return this.container.elements();
  }

  public void removeUser(String user)
  {
    if (user != null)
      this.container.removeElement(user);
  }

  public int getUserNum()
  {
    return this.container.size();
  }
}