Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50AAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 14:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbiF1O7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345917AbiF1O7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:59:44 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0E52B267;
        Tue, 28 Jun 2022 07:59:43 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 430A22130;
        Tue, 28 Jun 2022 14:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656428327;
        bh=vcqT4pndB/vuxi0YKM2w//7jCVGvaVOzx+QHC1eNVLo=;
        h=Date:To:CC:From:Subject;
        b=i/aWhnOVQvTsSi5S9tg8QtLi5rXfyRp3Jaft2o/8f4RVErHRd16ejsRfUDD/+m4yF
         esbd1qCt5f0gF8b1uOveQZZvRww7v/+uEhGxTSdGrqwqYih6lAg44KGCSh2O7ZYJXb
         CyYLn8GbHfginHTbIZs/FwNrnOpJsz0IsuCqabDU=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 28 Jun 2022 17:59:41 +0300
Message-ID: <1645cd93-5dc3-ea35-85ed-eba4e8d2e50e@paragon-software.com>
Date:   Tue, 28 Jun 2022 17:59:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Fix work with fragmented xattr
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases xattr is too fragmented,
so we need to load it before writing.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/xattr.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 1e849428bbc8..e581b2bd2b75 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -118,7 +118,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
  
  		run_init(&run);
  
-		err = attr_load_runs(attr_ea, ni, &run, NULL);
+		err = attr_load_runs_range(ni, ATTR_EA, NULL, 0, &run, 0, size);
  		if (!err)
  			err = ntfs_read_run_nb(sbi, &run, 0, ea_p, size, NULL);
  		run_close(&run);
@@ -444,6 +444,11 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
  		/* Delete xattr, ATTR_EA */
  		ni_remove_attr_le(ni, attr, mi, le);
  	} else if (attr->non_res) {
+		err = attr_load_runs_range(ni, ATTR_EA, NULL, 0, &ea_run, 0,
+					   size);
+		if (err)
+			goto out;
+
  		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size, 0);
  		if (err)
  			goto out;
-- 
2.36.1

