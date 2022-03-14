Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374DBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 07:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiCNHbl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiCNHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:31:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FE40937;
        Mon, 14 Mar 2022 00:30:28 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D580322238;
        Mon, 14 Mar 2022 08:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647243025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkJiyU6SyOytNL9RfBCdscNWweihr5Z98J++VGlbQ1I=;
        b=FEzSwfih/CXfXuRaID3WdSk3StdtiEAELsPNelCx6IST2HyLncodVeOTs0X91YgwyIcmN0
        bcxlIerxpB7qLjf07ysv4PKLs3NOGhBU2z2J86U0NZDphrIgXPOHXGUxRo0aeZgCupBNJo
        huRSom605AjvoEnoidgeVkqYeKN8Nbo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Mar 2022 08:30:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     heiko.thiery@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC
 outputs
In-Reply-To: <20220224103030.2040048-1-michael@walle.cc>
References: <20220224103030.2040048-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <00a28837f070d0964e55eafa1f2bb3f4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-02-24 11:30, schrieb Michael Walle:
> Use the power signal names as given in the schematics of the reference
> board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Any news here?

-michael
