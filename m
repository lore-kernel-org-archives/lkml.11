Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbiCUMhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347463AbiCUMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5013DDCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BB760BC3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37912C340E8;
        Mon, 21 Mar 2022 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647866141;
        bh=lTdH+WrottZcGG/Vs6gDo9up+kfKxDMLl59bqIEGt3g=;
        h=From:To:Cc:Subject:Date:From;
        b=qShRfMCLumh16iIr3Yw4abZ8AffRZrmztp9koesk+oCWLU9OXnvRpeyon2bhBQPFV
         nB2pP+bLr1dtG5ho3gaRTCj5fZO/+pzyQnPwhwzraAUo5wWG/hGVPnSsBnVb26zsIS
         1dBeQCIEPuoLbdAXqMEMrocLNNVtWPhjAg1rJCl2ePBPyZXbAN4pqckC0uvIJ6SYDy
         GDWMhaAMyiqhcZYZbtXKtpOUAYce7R4xZ4VL7ZJSMxVhP/imJh+z04nyHPmjTcNU3b
         D3aL/sNzcRjAUS0/ZVrkg5uRfQG2NFbNwGZKOQHj6zYSvpci4LDmGMC8gtU1IIrWDm
         M7GuMQs7ee6uA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.18
Date:   Mon, 21 Mar 2022 12:35:29 +0000
Message-Id: <20220321123541.37912C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.18

for you to fetch changes up to 0074f3f2b1e43d3cedd97e47fb6980db6d2ba79e:

  regmap: allow a defined reg_base to be added to every address (2022-03-18 16:53:19 +0000)

----------------------------------------------------------------
regmap: Updates for v5.18

A couple of small fixes, plus some new features that enable us to handle
devices that reformat register addresses depending on the bus used to
handle the control interface more gracefully.

----------------------------------------------------------------
Colin Foster (2):
      regmap: add configurable downshift for addresses
      regmap: allow a defined reg_base to be added to every address

Luca Ceresoli (1):
      regmap-irq: Fix typo in comment

Tom Rix (1):
      regmap: irq: cleanup comments

 drivers/base/regmap/internal.h   |  2 ++
 drivers/base/regmap/regmap-irq.c |  6 +++---
 drivers/base/regmap/regmap.c     | 11 +++++++++++
 include/linux/regmap.h           |  6 ++++++
 4 files changed, 22 insertions(+), 3 deletions(-)
