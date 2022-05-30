Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435C5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 16:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiE3QjL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiE3QjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:39:10 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0D57178;
        Mon, 30 May 2022 09:39:08 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 575961F86;
        Mon, 30 May 2022 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1653928716;
        bh=Cckc4s7C+CbZb8jiGkK5ijqtT9L5nMuyVbDLmo2FBhc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=m6c2uhg8sJdwJIiVqRJLsBqt71DdVduWZVK7weQHBNFHB8R2WhJcjdnQGOcaQYpJN
         go5fbpTN06a1oMF/jB8CZ0yUJgeEnp1dOlL/em+omtcQ3mSLPX/BsKueZO7G8mj6Pm
         rMZkgbk+i1ETqsytXx5ugBN4CjLZeoXQcPrb0728=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 May 2022 19:39:06 +0300
Message-ID: <b32932a7-65fc-95ac-1137-5d95b1e65a32@paragon-software.com>
Date:   Mon, 30 May 2022 19:39:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH v2 1/3] fs/ntfs3: Refactoring of indx_find function
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
References: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
In-Reply-To: <6afbf4c7-825b-7148-b130-55f720857cb0@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes function a bit more readable

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/index.c | 25 +++++++++----------------
  1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..8468cca5d54d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1042,19 +1042,16 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
  {
  	int err;
  	struct NTFS_DE *e;
-	const struct INDEX_HDR *hdr;
  	struct indx_node *node;
  
  	if (!root)
  		root = indx_get_root(&ni->dir, ni, NULL, NULL);
  
  	if (!root) {
-		err = -EINVAL;
-		goto out;
+		/* Should not happen. */
+		return -EINVAL;
  	}
  
-	hdr = &root->ihdr;
-
  	/* Check cache. */
  	e = fnd->level ? fnd->de[fnd->level - 1] : fnd->root_de;
  	if (e && !de_is_last(e) &&
@@ -1068,39 +1065,35 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
  	fnd_clear(fnd);
  
  	/* Lookup entry that is <= to the search value. */
-	e = hdr_find_e(indx, hdr, key, key_len, ctx, diff);
+	e = hdr_find_e(indx, &root->ihdr, key, key_len, ctx, diff);
  	if (!e)
  		return -EINVAL;
  
  	fnd->root_de = e;
-	err = 0;
  
  	for (;;) {
  		node = NULL;
-		if (*diff >= 0 || !de_has_vcn_ex(e)) {
-			*entry = e;
-			goto out;
-		}
+		if (*diff >= 0 || !de_has_vcn_ex(e))
+			break;
  
  		/* Read next level. */
  		err = indx_read(indx, ni, de_get_vbn(e), &node);
  		if (err)
-			goto out;
+			return err;
  
  		/* Lookup entry that is <= to the search value. */
  		e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
  			       diff);
  		if (!e) {
-			err = -EINVAL;
  			put_indx_node(node);
-			goto out;
+			return -EINVAL;
  		}
  
  		fnd_push(fnd, node, e);
  	}
  
-out:
-	return err;
+	*entry = e;
+	return 0;
  }
  
  int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
-- 
2.36.1


