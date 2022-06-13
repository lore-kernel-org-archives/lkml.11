Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 21:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352140AbiFMVOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiFMVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:13:19 -0400
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9523A;
        Mon, 13 Jun 2022 13:53:13 -0700 (PDT)
Received: from [77.244.183.192] (port=64104 helo=[192.168.178.42])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1o0r3f-0001vP-Is;
        Mon, 13 Jun 2022 22:53:11 +0200
Message-ID: <86596495-9c26-4915-9a39-395ea3a78553@lucaceresoli.net>
Date:   Mon, 13 Jun 2022 22:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] dt-bindings: clock: Move versaclock.h to
 dt-bindings/clock
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
 <20220613081632.2159-3-lukas.bulwahn@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <20220613081632.2159-3-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 13/06/22 10:16, Lukas Bulwahn wrote:
> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
> 
> This was discovered while investigating the state of ownership of the
> files in include/dt-bindings/ according to the MAINTAINERS file.
> 
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

(I'm switching to the Bootlin address, patches are out but the
MAINTAINERS one is not yet on master(

-- 
Luca
