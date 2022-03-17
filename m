Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 15:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiCQPtt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiCQPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:49:36 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F826C2;
        Thu, 17 Mar 2022 08:48:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8083CE0133;
        Thu, 17 Mar 2022 08:47:46 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N422I4rheLlB; Thu, 17 Mar 2022 08:47:45 -0700 (PDT)
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
Subject: [PATCH 0/7] TPS6598x PD tracing and other improvements
Date:   Thu, 17 Mar 2022 16:45:11 +0100
Message-Id: <20220317154518.4082046-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series developed for the Librem 5 phone, which uses TPS65982
as its USB-C controller. Implemented are Power Delivery sink contract
tracing and exporting negotiated power values as power supply properties,
fixes for data role swapping, status register caching and a debugfs entry
for querying customer use word of the firmware running on the controller.

Angus Ainslie (3):
  usb: typec: tipd: set the data role on tps IRQ
  usb: typec: tipd: Add trace event for SINK PD contract
  usb: typec: tipd: Provide POWER_SUPPLY_PROP_{CURRENT,VOLTAGE}_MAX

Guido Günther (2):
  usb: typec: tipd: Only update power status on IRQ
  usb: typec: tipd: Add debugfs entries for customer use word

Sebastian Krzyszkowiak (2):
  usb: typec: tipd: Provide POWER_SUPPLY_PROP_PRESENT
  usb: typec: tipd: Fail probe when the controller is in BOOT mode

 drivers/usb/typec/tipd/core.c     | 263 ++++++++++++++++++++++++++----
 drivers/usb/typec/tipd/tps6598x.h |  30 ++++
 drivers/usb/typec/tipd/trace.h    |  38 +++++
 3 files changed, 302 insertions(+), 29 deletions(-)

-- 
2.35.1

