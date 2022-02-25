Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE6C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 12:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiBYM1F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiBYM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:27:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9111D8;
        Fri, 25 Feb 2022 04:26:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023D0B82F57;
        Fri, 25 Feb 2022 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70300C340E7;
        Fri, 25 Feb 2022 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645791988;
        bh=XkDvs01GLoZYv9sesuOyEQE8tyc99VVk49LVS++JMPc=;
        h=From:To:Cc:Subject:Date:From;
        b=PPOvhOy22xjCyJJjQYxv6IJL9td9BEwfm5xkoCFbXOs6gbZagGmTIkRTq/SRGa85N
         iG9pKzwnZf2sqJ5ZuxFALhqEtnsZTtQ4SPYKgF/Eq1MZBZaKbFpJP4HGWbpyr1wZAt
         qyCbW/SJ+sfsA/bUyWoWbtMTUPhjBHpCWweZnGBuYgDU+D/tLB4IbOwFW7sszl5C8C
         COZkpvOthdju/7vIGuiW5XqPMxYtuSgudGm6DK+k696+2ZSFBum18bEgnIq02vhLHV
         D2hpA/M+mCEBJ9x37vvduebqAImTi6CfdjoC2txGQksU71wrV8k+W1mp/D+QrZZB0i
         RpgKoqxSq+OyQ==
From:   broonie@kernel.org
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: build failure after merge of the at91 tree
Date:   Fri, 25 Feb 2022 12:26:19 +0000
Message-Id: <20220225122619.1290024-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the at91 tree, today's linux-next build (arm multi_v7_defconfig)
failed like this:

Error: /tmp/next/build/arch/arm/boot/dts/sama7g5.dtsi:140.21-22 syntax error
FATAL ERROR: Unable to parse input tree

I didn't identify the specific commit that caused the issue, I have used
the at91 tree from yesterday instead.
