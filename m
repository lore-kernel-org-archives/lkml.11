Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiFXQyF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFXQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD39DF25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E6BFB82AA1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90CAC34114;
        Fri, 24 Jun 2022 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089641;
        bh=9lEqeLT40158plhXSRZcQRrVf+apdmuV6yuCiV3QD4I=;
        h=From:To:Cc:Subject:Date:From;
        b=acMag3TfFMzv4/fvxFLFGhJMJ0hco0ILy95bsFiLQ15+h7qCyh05yl37AANOpdpip
         JsLNnB58+HyCKdb+Lj58PDc0lRsXQNBX76ZFtQA68MT2ji7QUHhXSp5YatcgoDsYRb
         CWN2VICHF7sH9wHjxeCUREzznvMTx9jHUn9v9b5wBgLr6d+UF8XBXgPa9aEY2diNSn
         NPuPxUBchgpmJ2gMeiQ+tIUARAD9rJmpHa2KMrjIQnv7c6oUpy1rSHhxf3flJbpCk8
         J+wQZNzlnTUn19M3/wWmuTOk1kK1AbwpFfMfmG3OaOK5iHDJb7ihsHm8SgVQFqo40o
         OeCZCjiwxHkuA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.19-rc3
Date:   Fri, 24 Jun 2022 17:53:44 +0100
Message-Id: <20220624165400.B90CAC34114@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc3

for you to fetch changes up to 122e951eb8045338089b086c8bd9b0b9afb04a92:

  regulator: qcom_smd: correct MP5496 ranges (2022-06-07 20:38:09 +0100)

----------------------------------------------------------------
regulator: Fix for v5.19

One fix for an incorrect device description for MP5496.

----------------------------------------------------------------
Robert Marko (1):
      regulator: qcom_smd: correct MP5496 ranges

 drivers/regulator/qcom_smd-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
