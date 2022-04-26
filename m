Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC57C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 08:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbiDZIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbiDZIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2319E9F0;
        Tue, 26 Apr 2022 01:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 990C9B81CF3;
        Tue, 26 Apr 2022 08:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7619C385A0;
        Tue, 26 Apr 2022 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650961900;
        bh=7ZPOPnk1sXaTQkRJX3y14F/k4Em2x0E9p1XyCR9NRpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRobJJGQIvFbCZ5ZlmpZIAjsKFMDAWNDv2hdk4JK6DXToA7K9hpdDC4nv2GG+kuq8
         l5HsQTTNOu0Ph764VossAwJfuPhz6jWv6gxUCyed5B6MZhwz7IXV1K5AOdDyavLUJ6
         2xVFJg0FIpYOCul89T2eLI+G5v77tQK5ZgEaXT5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Grant <al.grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 51/62] arm_pmu: Validate single/group leader events
Date:   Tue, 26 Apr 2022 10:21:31 +0200
Message-Id: <20220426081738.684978378@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081737.209637816@linuxfoundation.org>
References: <20220426081737.209637816@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

commit e5c23779f93d45e39a52758ca593bd7e62e9b4be upstream.

In the case where there is only a cycle counter available (i.e.
PMCR_EL0.N is 0) and an event other than CPU cycles is opened, the open
should fail as the event can never possibly be scheduled. However, the
event validation when an event is opened is skipped when the group
leader is opened. Fix this by always validating the group leader events.

Reported-by: Al Grant <al.grant@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20220408203330.4014015-1-robh@kernel.org
Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm_pmu.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -322,6 +322,9 @@ validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
+	if (event == leader)
+		return 0;
+
 	for_each_sibling_event(sibling, leader) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
@@ -411,12 +414,7 @@ __hw_perf_event_init(struct perf_event *
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
-	if (event->group_leader != event) {
-		if (validate_group(event) != 0)
-			return -EINVAL;
-	}
-
-	return 0;
+	return validate_group(event);
 }
 
 static int armpmu_event_init(struct perf_event *event)


