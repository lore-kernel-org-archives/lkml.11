Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CBC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 11:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiFCL2e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:28:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B26289A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 424BBB8232B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58BFC385B8;
        Fri,  3 Jun 2022 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654255705;
        bh=EqGc+P0tONcO6nizjGhuBe1C0PNRcK0YubdUL4WmPXE=;
        h=From:To:Cc:Subject:Date:From;
        b=DUelBsEv98JlbPeJiCYLuNPRMugIEN8Y//ViBw49CdYLjJ5VLzzQY597FUa/ZEOi7
         mtEgTQZjy0ypbMduzRxX6Xwjmzn6iLKXrgl+rI5LnytrgzeL2fSiSyojz7YkEopNSB
         moL5t2CS36LmdteNr38bnT1SR7Org/DOZD6TY6f3Z10U3XAMpmUyTZ400ZFGaPOkTe
         AhZBeVv9vuicfKcKQnFk1/4xK2vU4rqO1eREwj5fGWdJvbAq1XjrzFGqJfu3Sr5d+3
         uN2pjWYYMWO2een+lFiZQYIKxEkc/P8XK2QY8Vv1i4g1xEPJf/7nOFgknOEXbR8mFn
         MJR97D2jIcatQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.19-rc0
Date:   Fri, 03 Jun 2022 13:28:08 +0200
Message-Id: <20220603112824.A58BFC385B8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 68d6c8476fd4f448e70e0ab31ff972838ac41dae:

  regulator: scmi: Fix refcount leak in scmi_regulator_probe (2022-05-17 11:58:13 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc0

for you to fetch changes up to 28cbc2d4c54c09a427b18a1604740efb6b2cc2d6:

  regulator: mt6315-regulator: fix invalid allowed mode (2022-06-01 12:24:11 +0200)

----------------------------------------------------------------
regulator: Fix for v5.19

One fix that came in during the merge window, fixing an error in
the examples in the DT binding documentation for mt6315.

----------------------------------------------------------------
Fabien Parent (1):
      regulator: mt6315-regulator: fix invalid allowed mode

 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
