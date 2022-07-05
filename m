Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5C4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiGEMO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiGEMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27B18B3D;
        Tue,  5 Jul 2022 05:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 668BEB817D3;
        Tue,  5 Jul 2022 12:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6BC341C7;
        Tue,  5 Jul 2022 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657022863;
        bh=TuA04bU4S7W29gSUxQ9KqRBna1fUPcT3K4e8ODxYOLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lj68n46PRisoed3V2MW6A0LYaI4sXq8RIgFv5+Nq4MZ7H6ty5ma9uDbbR2pAjJaHc
         Zqh/ztkYzJ0DOfodbEtGkfSO5MK0mkJckVOoZnMKWUTIgy13yWrAcV4m6tGnXHNhP9
         HFtzCFuPQRU3l7PfsFyq1IlCfp8QJX/K1OvGDqO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10 09/84] dm raid: fix KASAN warning in raid5_add_disks
Date:   Tue,  5 Jul 2022 13:57:32 +0200
Message-Id: <20220705115615.600640876@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115615.323395630@linuxfoundation.org>
References: <20220705115615.323395630@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 617b365872a247480e9dcd50a32c8d1806b21861 upstream.

There's a KASAN warning in raid5_add_disk when running the LVM testsuite.
The warning happens in the test
lvconvert-raid-reshape-linear_to_raid6-single-type.sh. We fix the warning
by verifying that rdev->saved_raid_disk is within limits.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8004,6 +8004,7 @@ static int raid5_add_disk(struct mddev *
 	 */
 	if (rdev->saved_raid_disk >= 0 &&
 	    rdev->saved_raid_disk >= first &&
+	    rdev->saved_raid_disk <= last &&
 	    conf->disks[rdev->saved_raid_disk].rdev == NULL)
 		first = rdev->saved_raid_disk;
 


