Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6AC3527A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386501AbiBGLeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383922AbiBGLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:24:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC5C043181;
        Mon,  7 Feb 2022 03:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3EA46149A;
        Mon,  7 Feb 2022 11:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0ADC004E1;
        Mon,  7 Feb 2022 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644233042;
        bh=xiY5lY35WAOg9QHGSqaxsrGkoe9bLoInwRS9wfYQ2Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdLWZJjKO/fHj5VAs7dXfkNOH+ibLB1ypzjmo30/oZHgaP8ENN+ZViv9UBkThlxLJ
         bM1pw/2KIvgOjxZ7WmP4U89A55uFo3XiIlMrYznKuJCTvnzBkPXzBxpAUydxKoDUV/
         pKV4TWuaBGyo3ZOkBfaqpVOaKirlO8ZD+y1dRMJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        stable@kernel.org, Xin Yin <yinxin.x@bytedance.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 71/74] ext4: fix incorrect type issue during replay_del_range
Date:   Mon,  7 Feb 2022 12:07:09 +0100
Message-Id: <20220207103759.557358261@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103757.232676988@linuxfoundation.org>
References: <20220207103757.232676988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Yin <yinxin.x@bytedance.com>

commit 8fca8a2b0a822f7936130af7299d2fd7f0a66714 upstream.

should not use fast commit log data directly, add le32_to_cpu().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 0b5b5a62b945 ("ext4: use ext4_ext_remove_space() for fast commit replay delete range")
Cc: stable@kernel.org
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/20220126063146.2302-1-yinxin.x@bytedance.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/fast_commit.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1771,8 +1771,9 @@ ext4_fc_replay_del_range(struct super_bl
 	}
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
-				lrange.fc_lblk + lrange.fc_len - 1);
+	ret = ext4_ext_remove_space(inode, le32_to_cpu(lrange.fc_lblk),
+				le32_to_cpu(lrange.fc_lblk) +
+				le32_to_cpu(lrange.fc_len) - 1);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (ret)
 		goto out;


