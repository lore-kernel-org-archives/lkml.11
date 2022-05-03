Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 13:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiECNv1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiECNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:51:26 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F52BDD;
        Tue,  3 May 2022 06:47:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0986C22239;
        Tue,  3 May 2022 15:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651585672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HELqmcny3+zb4t8KJj96rlX1j5P0rp+bwG6Pd4W7Nj0=;
        b=XHj+i/CZtrDSy5RFiDpnJIwa0HzP/ngi5kQAHKDEfSB2SURFh+P3MPRMcBj9Ag1hX33PzV
        MzUJ6b895a/JH7gI6yL3AUS8OsWFR+JMhsO0ObrMKGGSe6By87Ao4Em7mrBXIUisIJg0Fl
        fXuFxjDA5DcVqr0lJVfn9JeEWq7MIJE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 May 2022 15:47:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 5/9] arm64: dts: ls1028a: Update SFP binding to include
 clock
In-Reply-To: <20220428181703.2194171-6-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
 <20220428181703.2194171-6-sean.anderson@seco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <548f2e576a4c299a1139eadb30ca4e67@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-28 20:16, schrieb Sean Anderson:
> The clocks property is now mandatory. Add it.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Michael Walle <michael@walle.cc>

Fixes: eba5bea8f37f ("arm64: dts: ls1028a: add efuse node")
