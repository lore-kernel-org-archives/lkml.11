Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B76C54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 07:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIBH1b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBH12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:27:28 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D18B8F11;
        Fri,  2 Sep 2022 00:27:26 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EAEE29B1;
        Fri,  2 Sep 2022 09:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662103645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJHIUEiaDxr5x68L1+nV//9ggio2BTDcp2LsqHnXyjU=;
        b=h29H5dKn4/ohrnbMIIpMwikONwmOwdeRXiytcnTV4n//wU4QXqRNv1l/avf3Qy6VV1MGwb
        ws1jBsL/b3BIY2d5zpQiRSzQv+Tn5m//yi0JB/WzZEPw4aqX3Hwqn6qvwj3nvv/JgHnPcE
        qmf0Oy06Sy8NT7CtCdFNp/D0UT+MPTgdpWDX/jyreCWty410iRBdz+rVa007o1MFOZtAql
        D9sm6lh3XJ2MrqsBSAHuECoa5GTyV+5j7hCCa2dlLZCixUtYZkpd4xfaeEKibSO1gu+L0f
        vmAq6pnF2xFTTVpg4UO0VCSIcDin6NxMV20x0qEET+A8XhLiid8VD1jvjYmH4Q==
MIME-Version: 1.0
Date:   Fri, 02 Sep 2022 09:27:24 +0200
From:   Michael Walle <michael@walle.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 01/20] net: add helper eth_addr_add()
In-Reply-To: <3b86cb68-2b30-76dd-baf5-90af0b0a60a4@infradead.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-2-michael@walle.cc>
 <3b86cb68-2b30-76dd-baf5-90af0b0a60a4@infradead.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6fdadf867ed6ce4cdfe3f4b61e1de8be@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-02 01:22, schrieb Randy Dunlap:

>> +/**
>> + * eth_addr_add() - Add (or subtract) and offset to/from the given 
>> MAC address.
> 
>                                          an offset
> ?

yes thanks, I'll change that in the next version.

-michael
