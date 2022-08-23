Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A4C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244237AbiHWJT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350278AbiHWJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:16:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DCE895D2;
        Tue, 23 Aug 2022 01:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E7DB81C29;
        Tue, 23 Aug 2022 08:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D71C433C1;
        Tue, 23 Aug 2022 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243567;
        bh=ho87OgdVd2lfgHZPkZVU6G4Js8hh1GLxQWbGPKq8aXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xCo5W5p599fYskNkW9fPEJQ68bFA2IBKn/keqAhYrAw+zHwcWr0nuu7b3ZGX0JcBQ
         x8qUBIusIpqtrqQedLp7m0uV2NZhmNORtsiPBJhbx0/hF/MFtTsLCH/ebRnXWUuKcZ
         Kt21s8hEa1lR+E0MdToyLTOrflV9TXdiyYd4JUaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Kiselev <okiselev@amazon.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 317/365] ext4: avoid resizing to a partial cluster size
Date:   Tue, 23 Aug 2022 10:03:38 +0200
Message-Id: <20220823080131.440477452@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiselev, Oleg <okiselev@amazon.com>

[ Upstream commit 69cb8e9d8cd97cdf5e293b26d70a9dee3e35e6bd ]

This patch avoids an attempt to resize the filesystem to an
unaligned cluster boundary.  An online resize to a size that is not
integral to cluster size results in the last iteration attempting to
grow the fs by a negative amount, which trips a BUG_ON and leaves the fs
with a corrupted in-memory superblock.

Signed-off-by: Oleg Kiselev <okiselev@amazon.com>
Link: https://lore.kernel.org/r/0E92A0AB-4F16-4F1A-94B7-702CC6504FDE@amazon.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e5c2713aa11a..cb5a64293881 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1989,6 +1989,16 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	}
 	brelse(bh);
 
+	/*
+	 * For bigalloc, trim the requested size to the nearest cluster
+	 * boundary to avoid creating an unusable filesystem. We do this
+	 * silently, instead of returning an error, to avoid breaking
+	 * callers that blindly resize the filesystem to the full size of
+	 * the underlying block device.
+	 */
+	if (ext4_has_feature_bigalloc(sb))
+		n_blocks_count &= ~((1 << EXT4_CLUSTER_BITS(sb)) - 1);
+
 retry:
 	o_blocks_count = ext4_blocks_count(es);
 
-- 
2.35.1



