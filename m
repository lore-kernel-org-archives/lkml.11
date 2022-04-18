Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3CBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 19:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347693AbiDRTZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 15:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbiDRTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:25:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8E35A86;
        Mon, 18 Apr 2022 12:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92EFEB81088;
        Mon, 18 Apr 2022 19:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ADFC385A7;
        Mon, 18 Apr 2022 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309775;
        bh=uzk/s8emvG9nDrcA+e8Yg2zneacs8ZthnnmYD/0bdtM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Zz1KqBGM+a9/gGati0Ftr0g47FW9dilYz4HODzX8x+64dPkWRzFu6S7h4rlwPfy9g
         q3fCul8R8BXZcOCS+26vF1pfROek4Vg3qZnQI4ik/4yrBkkrWeh12eBv8Xf94MzB6l
         sG8bXmfk19IJPgArxzI8B7fxj8xDlMg2tde5kIRAelBKWUFzPt5dc5NXuTu5cTHKPQ
         Jsqhcs5IGu4YX/TEC/iPgYip+HiYW8NNyZBtvYtmiYNlpJ+JJ0Je/ZdGf5tc9wmaTG
         VUJuXVlkyCIVzre//04aE3ph/WcMjMxtv7d2thmqfNuA+b78LGm88Rbq7IIy3JubZI
         GR/mQ9P/l1SVw==
Message-ID: <e0478a30-fe24-d141-4b6b-313d184df320@kernel.org>
Date:   Mon, 18 Apr 2022 12:22:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARC: dts: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vineet Gupta <vgupta@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220407143322.295696-1-krzysztof.kozlowski@linaro.org>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220407143322.295696-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 07:33, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
>
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>

Applied.

Thx,
-Vineet
