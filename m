Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C8C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jul 2022 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiGXRst (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:48:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153311441;
        Sun, 24 Jul 2022 10:48:44 -0700 (PDT)
Received: from dslb-178-004-201-227.178.004.pools.vodafone-ip.de ([178.4.201.227] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oFfiR-0005LM-QJ; Sun, 24 Jul 2022 19:48:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 0/2] ARM: imx25: print silicon revision at startup
Date:   Sun, 24 Jul 2022 19:47:35 +0200
Message-Id: <20220724174737.212028-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602080344.208702-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect the unused function to print the imx25 silicon revision at
startup.

It's been a month since I sent v2. I'm resending the series, hoping to
get a response this time. Thanks in advance.

changes in v3:
- rebase against today's linux-next

changes in v2:
- drop the patch about silicon revision 1.2. It has already been merged
  by Shawn Guo.
- send the changeset to the clk maintainers

Martin Kaiser (2):
  clk: imx25: print silicon revision during init
  clk: imx25: make __mx25_clocks_init return void

 drivers/clk/imx/clk-imx25.c | 5 +++--
 include/soc/imx/revision.h  | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.30.2

