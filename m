Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12719C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 11:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbiAaLWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 06:22:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58344 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359040AbiAaLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:10:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B3EAB82A72;
        Mon, 31 Jan 2022 11:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5A4C340E8;
        Mon, 31 Jan 2022 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643627455;
        bh=0EFvWCyzPTR972W2aSbT7/hxxvBhl8DPD0Oj9l1LhLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psvL7yjnO4jDIIRdbwDjsb5NojN0mivf9/+Pq+tyhrmJmgKlX+OnMwD92fQgKaUxY
         2F+mm3JEBYRm67PIjB7YUs3m6SUZf4RzUfCt3CveG5i4VfHbnEaeLlKnVRCO0vGm3G
         /bEe//KTJA8InGniDtSqnYC26UkrVV4Ap0e6hKnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/171] hwmon: (lm90) Mark alert as broken for MAX6680
Date:   Mon, 31 Jan 2022 11:55:54 +0100
Message-Id: <20220131105233.045950528@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131105229.959216821@linuxfoundation.org>
References: <20220131105229.959216821@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

commit 94746b0ba479743355e0d3cc1cb9cfe3011fb8be upstream.

Experiments with MAX6680 and MAX6681 show that the alert function of those
chips is broken, similar to other chips supported by the lm90 driver.
Mark it accordingly.

Fixes: 4667bcb8d8fc ("hwmon: (lm90) Introduce chip parameter structure")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm90.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -418,7 +418,7 @@ static const struct lm90_params lm90_par
 	},
 	[max6680] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_CRIT
-		  | LM90_HAVE_CRIT_ALRM_SWP,
+		  | LM90_HAVE_CRIT_ALRM_SWP | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 		.max_convrate = 7,
 	},


