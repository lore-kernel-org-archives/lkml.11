Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABDC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jul 2022 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGXPev (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:34:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17155C64
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:34:49 -0700 (PDT)
Received: from dslb-178-004-201-227.178.004.pools.vodafone-ip.de ([178.4.201.227] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oFdcv-0004Lf-3T; Sun, 24 Jul 2022 17:34:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] staging: r8188eu: remove two unused function prototypes
Date:   Sun, 24 Jul 2022 17:33:47 +0200
Message-Id: <20220724153349.138741-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to remove the prototypes of OnAtim and DoReserved when those
functions were removed. Here's two patches to fix this.

Martin Kaiser (2):
  staging: r8188eu: remove OnAtim prototype
  staging: r8188eu: remove DoReserved prototype

 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.30.2

