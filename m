Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31582C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 16:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356046AbiDCQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiDCQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:56:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DA326D9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:54:49 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3Uz-0008D7-Ir; Sun, 03 Apr 2022 18:54:45 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/11] staging: r8188eu: clean up validate_recv_data_frame
Date:   Sun,  3 Apr 2022 18:54:27 +0200
Message-Id: <20220403165438.357728-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ieee80211 helpers, remove temporary variables, simplify the error
handling. Refactor the code for checking to_ds, from_ds.

Martin Kaiser (11):
  staging: r8188eu: use ieee80211 helper for source address
  staging: r8188eu: use ieee80211 helper for destination address
  staging: r8188eu: use ieee80211 helper for retry bit
  staging: r8188eu: simplify error handling
  staging: r8188eu: to_fr_ds cannot be 3 here
  staging: r8188eu: don't copy ra and ta before we fail
  staging: r8188eu: remove to_fr_ds from struct rx_pkt_attrib
  staging: r8188eu: ra and ta do not depend on to_ds, from_ds
  staging: r8188eu: remove psa, pda
  staging: r8188eu: don't call get_hdr_bssid
  staging: r8188eu: remove the bretry variable

 drivers/staging/r8188eu/core/rtw_recv.c    | 84 +++++++---------------
 drivers/staging/r8188eu/include/rtw_recv.h |  1 -
 drivers/staging/r8188eu/include/wifi.h     |  2 -
 3 files changed, 26 insertions(+), 61 deletions(-)

-- 
2.30.2

