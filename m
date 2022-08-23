Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941EC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiHWIOW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbiHWIKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:10:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C869F4B;
        Tue, 23 Aug 2022 01:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38CB9B81BF8;
        Tue, 23 Aug 2022 08:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C10DC433C1;
        Tue, 23 Aug 2022 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242056;
        bh=Vh/TLHB55jz6Qfv0o55O44R0jumQnALWfdNVxIVP/nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6qsvuXD34NQ51ff1lBCCSjBASyxu7I6jZ4e9J0QJrEXnkDyvSpgdoMUzEKNbdPkV
         Hx0ubhwe4pC2j5w+zJxGVnhngkCGDZ4svYbQDmth5HKQvRlsyjRzQ6K1bk9TUBbD53
         k8SMdt1kk7RAbYKFAq8mbmkOfcZIdhd6sNnrgmmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Alexander Grund <theflamefire89@gmail.com>
Subject: [PATCH 4.9 012/101] selinux: Clean up initialization of isec->sclass
Date:   Tue, 23 Aug 2022 10:02:45 +0200
Message-Id: <20220823080035.044590894@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 13457d073c29da92001f6ee809075eaa8757fb96 upstream.

Now that isec->initialized == LABEL_INITIALIZED implies that
isec->sclass is valid, skip such inodes immediately in
inode_doinit_with_dentry.

For the remaining inodes, initialize isec->sclass at the beginning of
inode_doinit_with_dentry to simplify the code.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1395,12 +1395,15 @@ static int inode_doinit_with_dentry(stru
 	int rc = 0;
 
 	if (isec->initialized == LABEL_INITIALIZED)
-		goto out;
+		return 0;
 
 	mutex_lock(&isec->lock);
 	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
 
+	if (isec->sclass == SECCLASS_FILE)
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
@@ -1518,7 +1521,6 @@ static int inode_doinit_with_dentry(stru
 		isec->sid = sbsec->sid;
 
 		/* Try to obtain a transition SID. */
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		rc = security_transition_sid(isec->task_sid, sbsec->sid,
 					     isec->sclass, NULL, &sid);
 		if (rc)
@@ -1554,7 +1556,6 @@ static int inode_doinit_with_dentry(stru
 			 */
 			if (!dentry)
 				goto out_unlock;
-			isec->sclass = inode_mode_to_security_class(inode->i_mode);
 			rc = selinux_genfs_get_sid(dentry, isec->sclass,
 						   sbsec->flags, &sid);
 			dput(dentry);
@@ -1569,9 +1570,6 @@ static int inode_doinit_with_dentry(stru
 
 out_unlock:
 	mutex_unlock(&isec->lock);
-out:
-	if (isec->sclass == SECCLASS_FILE)
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	return rc;
 }
 


