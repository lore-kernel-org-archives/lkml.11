Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FECC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiFOAtr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiFOAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:49:35 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC04C42F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mxlPCZ+TCo9rjngJAxk2JBd7q9Ja8RZEj1mwABWaau0=; b=h74dKSNXJXZm3a9VcOIeLwvGgB
        RUviIBUqsjNtUgf2SeURHeDSoRjFUOekmIqk9B1MuyPD/4lm3zvNQoLfoXJaruHNvuOikC7AGKxfh
        kk47PMpcwyjffumHdD6nogllYhtQLNheuM6bu9HHDUWmoPxDlmK1A69t0a1rhKbwiRD8=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1HDt-0002Sr-SX; Tue, 14 Jun 2022 17:49:29 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH v2 0/4] call rtw_IOL_append_*_cmd directly
Date:   Tue, 14 Jun 2022 17:49:24 -0700
Message-Id: <cover.1655249804.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

This patchset calls the rtw_IOL_append_*_cmd group of functions
directly and removes the #define wrappers.

Daniel Watson (4):
  staging: r8188eu: call rtw_IOL_append_WB_cmd directly
  staging: r8188eu: call rtw_IOL_append_WW_cmd directly
  staging: r8188eu: call rtw_IOL_append_WD_cmd directly
  staging: r8188eu: call rtw_IOL_append_WRF_cmd directly

 drivers/staging/r8188eu/core/rtw_iol.c    |  8 ++++----
 drivers/staging/r8188eu/include/rtw_iol.h | 24 ++++++++---------------
 2 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.34.1

