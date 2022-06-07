Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C226C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 22:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383400AbiFGWXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380737AbiFGVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:16:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D1147829;
        Tue,  7 Jun 2022 11:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3873DB822C0;
        Tue,  7 Jun 2022 18:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E2BC385A2;
        Tue,  7 Jun 2022 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654628216;
        bh=sCtI21mHmu6eCFDwJDJ9ANTa+yy3I1+xzGJmloI8pJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5wLjeb3RPGOmKv3e2nv6AqIV3v/n2bGu7gav7QZ4CExuyg7jklcBDZnNVJa1bFgk
         CB9/4VH/fOKaIOMw9hOqjjEWV9H95ZKNSTPebnENN5YS0kYsEKZiLRPEigxsPOad0D
         Z6S227laD8izi9PKXZY4Bbusug0+nt6QlnLaWQhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 249/879] smb3: check for null tcon
Date:   Tue,  7 Jun 2022 18:56:07 +0200
Message-Id: <20220607165010.078321192@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit bbdf6cf56c88845fb0b713cbf5c6623c53fe40d8 ]

Although unlikely to be null, it is confusing to use a pointer
before checking for it to be null so move the use down after
null check.

Addresses-Coverity: 1517586 ("Null pointer dereferences  (REVERSE_INULL)")
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 2df9aab12db7..861291662c95 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -760,8 +760,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		struct cifs_sb_info *cifs_sb,
 		struct cached_fid **cfid)
 {
-	struct cifs_ses *ses = tcon->ses;
-	struct TCP_Server_Info *server = ses->server;
+	struct cifs_ses *ses;
+	struct TCP_Server_Info *server;
 	struct cifs_open_parms oparms;
 	struct smb2_create_rsp *o_rsp = NULL;
 	struct smb2_query_info_rsp *qi_rsp = NULL;
@@ -779,6 +779,9 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (tcon->nohandlecache)
 		return -ENOTSUPP;
 
+	ses = tcon->ses;
+	server = ses->server;
+
 	if (cifs_sb->root == NULL)
 		return -ENOENT;
 
-- 
2.35.1



