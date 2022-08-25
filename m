Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C197C32774
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 06:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiHYGNw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiHYGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:13:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A769F754
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:13:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so26913708lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wlxyyEdyz9YeaP+PKKdOU9ZrYBY0DMAseQm1V42ntwY=;
        b=UPsydeRD7QmyNX/kxeY7lnbMw8ie0nb0OcFrbQmJnaxJ6xd8fOfUaQYv1HClHxFWY9
         6Rnsl+fo0GzF/eGP/wAUkgjfz+5e6Bx6m/c6XN2xIHnuTh2E4N+99ZRmtffu7EpXPqKE
         WZGM2MQLyqUebHOwjMVTRo+BE4arXXFGOiuMkk9LQ3cj8tyKygNyMACti9WBehBXcR3G
         nyoCzs12K4eFrNEz0BLTAQJ3vkgKE5f/52AVZ6Cy+ttumgSp+GTUMbaa46OZbmn5KPF+
         l/8cCWewOQG7ojKLIJoDQPjT1CP44wbuyX12WzJm39iXkLkuYfIwiP7HFNix/58PLeNS
         8a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wlxyyEdyz9YeaP+PKKdOU9ZrYBY0DMAseQm1V42ntwY=;
        b=gqCKDvgS8+JWEByAYcsLIKleQeEguJzVe7ontg2prKEsOrfjcSwfzV7zEJ/XYeFQTE
         f7JfnP6CVXv5cs0pr1twz1+iAWi4uBvuuKHjK+LYLAKaCj50TsJM0oNzLZuR4Al6qHPH
         yiUw+1NdHdx38EfmZqKJtWQy4QXYhdleoAdJsLbKmq4UTYJ+kRYF+1k/JvEkGyc3XEe1
         r6XoYPUDuoAz261cc3ue+Sr2F5OPMbI62Hn5vUGjQxK945elD0IWCcGykcwVYbaRG14v
         5DzcwlRaSEGMAKnqBZChJMzWj7fCMd6X4yUDj3jNjpqos0bTY8DUB46eNwZT5OFmTcX6
         RYMw==
X-Gm-Message-State: ACgBeo27dLPqn1pAe3xhZx7X5XRPgkkxOP9I2Zjo1be62pdZxtqGqAYe
        f6gVpkN2iQXkxstMV5J4wnL1OA==
X-Google-Smtp-Source: AA6agR7UqmyD7JRBfuRRmBmdO0IXT/oW/WrgCHd1/0DNqYVZ+wtbYs/xMKgsSXJIPZ4+fxXOwAvASw==
X-Received: by 2002:a05:6512:3a90:b0:48a:fcf6:3137 with SMTP id q16-20020a0565123a9000b0048afcf63137mr605815lfu.255.1661408027387;
        Wed, 24 Aug 2022 23:13:47 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25091000000b0048a8586293asm323218lfm.48.2022.08.24.23.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:13:46 -0700 (PDT)
Message-ID: <b906210e-6857-82bf-755b-760e33d3a338@linaro.org>
Date:   Thu, 25 Aug 2022 09:13:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824160715.95779-1-povik+lin@cutebit.org>
 <20220824160715.95779-2-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824160715.95779-2-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 19:07, Martin Povišer wrote:
> Add binding schema for MCA I2S transceiver found on Apple M1 and other
> chips.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
