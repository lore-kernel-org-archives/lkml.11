Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2629EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiCQPuN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiCQPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:50:05 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682FBB931;
        Thu, 17 Mar 2022 08:48:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 09CCBE0142;
        Thu, 17 Mar 2022 08:48:15 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wm80spgabJ9o; Thu, 17 Mar 2022 08:48:14 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Angus Ainslie <angus@akkea.ca>,
        Hector Martin <marcan@marcan.st>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 5/7] usb: typec: tipd: Provide POWER_SUPPLY_PROP_PRESENT
Date:   Thu, 17 Mar 2022 16:45:16 +0100
Message-Id: <20220317154518.4082046-6-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
References: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows userspace and downstream supplies to know whether
something is plugged in.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f3e8f1183f5b..874528b02a99 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -108,6 +108,7 @@ struct tps6598x {
 static enum power_supply_property tps6598x_psy_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
 };
@@ -756,6 +757,9 @@ static int tps6598x_psy_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = tps6598x_psy_get_online(tps, val);
 		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = !!tps->partner;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		ret = tps6598x_psy_get_max_current(tps, val);
 		break;
-- 
2.35.1

