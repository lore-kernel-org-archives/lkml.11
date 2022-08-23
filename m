Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B39DC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358389AbiHWLtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358368AbiHWLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F56D2900;
        Tue, 23 Aug 2022 02:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82C5EB81B1F;
        Tue, 23 Aug 2022 09:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE104C433C1;
        Tue, 23 Aug 2022 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247033;
        bh=4g35WAg052vHuZSfWEdDgYPobHSETza8tCzS0GKZIpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gmt1H5jcL/YvNbjiRa5RQ8BwOderiKLkuwmAduchZ1BJwjHis9ak2L4MM9i2DrBZJ
         MSL6vpA+G/dyZxH3smUiVKChWuXj630WFejTGg83ivsfj8zJcZOCiWEPHJiNKXfFdx
         4Hw03Irl2GmcYUNCgB+IoGkuMDhH+KEC40HWPuNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.4 267/389] dm raid: fix address sanitizer warning in raid_resume
Date:   Tue, 23 Aug 2022 10:25:45 +0200
Message-Id: <20220823080126.722700015@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7dad24db59d2d2803576f2e3645728866a056dab upstream.

There is a KASAN warning in raid_resume when running the lvm test
lvconvert-raid.sh. The reason for the warning is that mddev->raid_disks
is greater than rs->raid_disks, so the loop touches one entry beyond
the allocated length.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3808,7 +3808,7 @@ static void attempt_restore_of_faulty_de
 
 	memset(cleared_failed_devices, 0, sizeof(cleared_failed_devices));
 
-	for (i = 0; i < mddev->raid_disks; i++) {
+	for (i = 0; i < rs->raid_disks; i++) {
 		r = &rs->dev[i].rdev;
 		/* HM FIXME: enhance journal device recovery processing */
 		if (test_bit(Journal, &r->flags))


