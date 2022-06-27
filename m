Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D62C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiF0LX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiF0LXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F966575;
        Mon, 27 Jun 2022 04:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375626144F;
        Mon, 27 Jun 2022 11:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28268C341C7;
        Mon, 27 Jun 2022 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656328997;
        bh=A2migJAf3lhueRVP05DdDRYtA3dnSY0+3MDuPOjx5+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMp4h5yfo//noILpdkD21PkSvza8b+/+tqWEDFSvUNE4LOLr7p8KNW4ZBlVnXd2b8
         vetYpyRnrCrLGBp1n55DnLfd71K23GabwzarXJ5PuKnvs6BedV+ryr/d47eHwteeTm
         Q6dZrzD89yNOreg5tsrZnPtqJKLSpbavYH7trIxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10 017/102] dm mirror log: clear log bits up to BITS_PER_LONG boundary
Date:   Mon, 27 Jun 2022 13:20:28 +0200
Message-Id: <20220627111933.977067159@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111933.455024953@linuxfoundation.org>
References: <20220627111933.455024953@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 90736eb3232d208ee048493f371075e4272e0944 upstream.

Commit 85e123c27d5c ("dm mirror log: round up region bitmap size to
BITS_PER_LONG") introduced a regression on 64-bit architectures in the
lvm testsuite tests: lvcreate-mirror, mirror-names and vgsplit-operation.

If the device is shrunk, we need to clear log bits beyond the end of the
device. The code clears bits up to a 32-bit boundary and then calculates
lc->sync_count by summing set bits up to a 64-bit boundary (the commit
changed that; previously, this boundary was 32-bit too). So, it was using
some non-zeroed bits in the calculation and this caused misbehavior.

Fix this regression by clearing bits up to BITS_PER_LONG boundary.

Fixes: 85e123c27d5c ("dm mirror log: round up region bitmap size to BITS_PER_LONG")
Cc: stable@vger.kernel.org
Reported-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-log.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -615,7 +615,7 @@ static int disk_resume(struct dm_dirty_l
 			log_clear_bit(lc, lc->clean_bits, i);
 
 	/* clear any old bits -- device has shrunk */
-	for (i = lc->region_count; i % (sizeof(*lc->clean_bits) << BYTE_SHIFT); i++)
+	for (i = lc->region_count; i % BITS_PER_LONG; i++)
 		log_clear_bit(lc, lc->clean_bits, i);
 
 	/* copy clean across to sync */


