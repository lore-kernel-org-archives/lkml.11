Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 12:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbiC3MVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbiC3MDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9F288A9A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026AF61729
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D86C340EE;
        Wed, 30 Mar 2022 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648641456;
        bh=QQWsSLY6ur47t03mOAu3XMgDUScZQZIYUq4HZYvZhxs=;
        h=From:To:Cc:Subject:Date:From;
        b=T7E74smq2J23y9R7TXuqYsUGVkqrhjYE+v64dzmCUu4pdpDkBI1f5wF7M5q10xr4F
         sQBfP3tMblvllWl1fhnz4kdJzR1h+wjrnumCkEY0f4prA1wDeUsETAjSGZrGJNC6G3
         0TkRcJpqU+xzTjo920tdLuGcOVJiIgxq5GkILKLUgtXtVx8jOVE4NBdFp9IC2CA9On
         M8AhlWRqGNNTWCgc5g/e+KLb9HOMsV8GfOVall0go8Pv2dshlZMYc6gF6Dm1nv4+o4
         ViA46D3p2hAMIsgUuTLtbIxQazCiM2pb3eGDCxn9UF2hkBlmkn1HvLKB7sJPaxRTOR
         1Aj1b6jSZAHcA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.18
Date:   Wed, 30 Mar 2022 12:57:21 +0100
Message-Id: <20220330115736.03D86C340EE@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5999f85ddeb436b4007878f251a30ccc8b9c638b:

  regulator: qcom-rpmh: Add support for SDX65 (2022-03-18 16:05:06 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18

for you to fetch changes up to aefe5fc3000a24869edbf7bb657adf28372ec158:

  regulator: rt4831: Add active_discharge_on to fix discharge API (2022-03-25 16:09:31 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.18

A couple of fixes for the rt4831 driver which fix features that didn't
work due to incomplete description of the register configuration.

----------------------------------------------------------------
ChiYuan Huang (2):
      regulator: rt4831: Add bypass mask to fix set_bypass API work
      regulator: rt4831: Add active_discharge_on to fix discharge API

 drivers/regulator/rt4831-regulator.c | 3 +++
 1 file changed, 3 insertions(+)
