Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540DFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Mar 2022 18:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiCTSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:04:47 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316723C713;
        Sun, 20 Mar 2022 11:03:24 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id k125so10383741qkf.0;
        Sun, 20 Mar 2022 11:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFYTlV3ZvJ5BnTSe102STqzCL7q/7lu5pRd287m26OU=;
        b=vbT2I5RSwJx0Cs2NZEPJ0+iHj/ynzZFBPrwv4902+RIjtywOnPU0hDtykAdkYr9nwe
         xfmNm14/cMfyrGoo6RPXtCQIMcR9xC+0Xw3a/tjGuoswsBiMiTH47j5FORPA1uE8MnPT
         Fu0i/XwgmZTviSlMud99M2yVQ4Tr0HHIst/meISrScA8czS+5rOKFHgZdBO3NCcRltu2
         VSjFplJMQyqYNmWmC3PTy2mT8vCcZaEDe3fHaM1QqJIuzJZ1OGzqu2ZHjgkU0zvARpSp
         spDkFBMlrkgleNfBueKng2fAGLBZaLyeFzohcYdyPXclUXM2Re+oKXxc6tBZqvvpZq+r
         JWig==
X-Gm-Message-State: AOAM533hAIbzpyCpvQoY8KTzJ1XBpQ2Wb32yJ2LsEihRlnX/Gki0DgMG
        1Zdu/LbaVpLWQUn+KWs4Yg==
X-Google-Smtp-Source: ABdhPJzdIBtEYUOictCAqbOBGdBoDlXAOfB8oyzDiVx1mSkD20ZXRm1ghfcgtIDuTNitJe9dBvE9aA==
X-Received: by 2002:a05:620a:290f:b0:67b:3212:d529 with SMTP id m15-20020a05620a290f00b0067b3212d529mr10754269qkp.4.1647799403232;
        Sun, 20 Mar 2022 11:03:23 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm8163270qtc.50.2022.03.20.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:03:21 -0700 (PDT)
Received: (nullmailer pid 3128961 invoked by uid 1000);
        Sun, 20 Mar 2022 18:03:15 -0000
Date:   Sun, 20 Mar 2022 14:03:15 -0400
From:   Rob Herring <robh@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH v4 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41
 External Boost
Message-ID: <YjdsY9tcuDmvYYQk@robh.at.kernel.org>
References: <20220317093120.168534-1-tanureal@opensource.cirrus.com>
 <20220317093120.168534-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317093120.168534-16-tanureal@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:31:19AM +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Document internal and external boost feature for ASoC CS35L41.
> For internal boost the following properties are required:
> - cirrus,boost-peak-milliamp
> - cirrus,boost-ind-nanohenry
> - cirrus,boost-cap-microfarad
> 
> For external boost, the GPIO1 must be configured as output,
> so the following properties are required:
> - cirrus,gpio1-src-select = <1>
> - cirrus,gpio1-output-enable
> 
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)

With the indentation fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

