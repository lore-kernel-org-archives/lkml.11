Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 00:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348665AbiE0AAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbiE0AAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:00:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28586F494
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:00:33 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B59520B894E;
        Thu, 26 May 2022 17:00:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B59520B894E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609633;
        bh=yXi1WGiCy9BLSBAV0/nUcn1Q6XY2f9IytAcNKCT0ldE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPVlWctq92O8hM0R654SAHPmKsSHY42k7UK+R1Rle+ZGMvFRyNcjnfqnzJKwC7FtB
         IbibTty/LulnMDsB3fPAXu/X7sEGoO3s2gjZEboI8+ovK9BxzBki6QaJKvfgzP4Kh3
         NtA+AMKQofdBs/1vvF9gadI0Cj0uuRGg1kjmHGnU=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] 9p: Fix minor typo in code comment
Date:   Thu, 26 May 2022 19:00:03 -0500
Message-Id: <20220527000003.355812-6-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix s/patch/path/ typo and make it clear that we're talking about
multiple path components.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 fs/9p/fid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index d8c70c4cd3c2..60fc62081598 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -219,7 +219,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		l = min(n - i, P9_MAXWELEM);
 		/*
 		 * We need to hold rename lock when doing a multipath
-		 * walk to ensure none of the patch component change
+		 * walk to ensure none of the path components change
 		 */
 		fid = p9_client_walk(old_fid, l, &wnames[i],
 				     old_fid == root_fid);
-- 
2.25.1

