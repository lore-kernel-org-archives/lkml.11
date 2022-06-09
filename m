Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A64BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 12:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbiFIMED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiFIMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68486A40C;
        Thu,  9 Jun 2022 05:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63953611EE;
        Thu,  9 Jun 2022 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B9DC341C0;
        Thu,  9 Jun 2022 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776237;
        bh=IIOOxZh80ZyBxPn4yE0l0GHTW4scpjWh6p2VRV8u1XQ=;
        h=From:To:Cc:Subject:Date:From;
        b=U2GLB01mvtaqy0R1wjSjwtLBhODHcBcToEiCYaycOHJlyWxj3eb9zuG8izqehmQEx
         PaSfY0mnkyklnOErDAHCX2sYFV1qMVEGhr5coEj2i7L3T5Xbt6TYFeJRKbjpmi9Z6w
         HeUDpaS/t58KiMnA1kWMAdamkq7im6J6qSmiMnjJXqAyDP9TrFQQQvmDiD0ApBrUPI
         ruxUW3r40XtifAhiuo7vNwFqqBpdkPKeOkYcHTQJzxgNygytwMpIUh8I2mnzUKQowM
         Q5Z07Zi302mS8kCzAD1QZCbI4yQsRv4EylcO5tddP9tfNeiXaSg95WpEEMA1RIboTA
         P1F5N1O2mhNWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nzGtF-00014B-KY; Thu, 09 Jun 2022 14:03:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp: clean up defines
Date:   Thu,  9 Jun 2022 14:03:35 +0200
Message-Id: <20220609120338.4080-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some trivial cleanups of the QMP defines for issues found while
adding support for SC8280XP.

Johan


Johan Hovold (3):
  phy: qcom-qmp: clean up v4 and v5 define order
  phy: qcom-qmp: clean up define alignment
  phy: qcom-qmp: clean up hex defines

 drivers/phy/qualcomm/phy-qcom-qmp.h | 70 ++++++++++++++---------------
 1 file changed, 35 insertions(+), 35 deletions(-)

-- 
2.35.1

