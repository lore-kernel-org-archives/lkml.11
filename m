Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 05:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiDCFxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 01:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiDCFxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:53:39 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCD3B01D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 22:51:45 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id at9JnoLlRN7Ccat9JnMpFF; Sun, 03 Apr 2022 07:51:43 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 07:51:43 +0200
X-ME-IP: 90.126.236.122
Message-ID: <93751991-30ce-93a0-0f33-105f99b8dfe3@wanadoo.fr>
Date:   Sun, 3 Apr 2022 07:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Fix missing
 clk_disable_unprepare() in msm8916_wcd_digital_probe
Content-Language: fr
To:     Miaoqian Lin <linmq006@gmail.com>
References: <20220307084523.28687-1-linmq006@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220307084523.28687-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/03/2022 à 09:45, Miaoqian Lin a écrit :
> Fix the missing clk_disable_unprepare() before return
> from msm8916_wcd_digital_probe in the error handling case.
> 
> Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   sound/soc/codecs/msm8916-wcd-digital.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
> index fcc10c8bc625..9ad7fc0baf07 100644
> --- a/sound/soc/codecs/msm8916-wcd-digital.c
> +++ b/sound/soc/codecs/msm8916-wcd-digital.c
> @@ -1201,7 +1201,7 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
>   	ret = clk_prepare_enable(priv->mclk);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to enable mclk %d\n", ret);
> -		return ret;
> +		goto err_clk;
>   	}
>   
>   	dev_set_drvdata(dev, priv);
> @@ -1209,6 +1209,9 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
>   	return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
>   				      msm8916_wcd_digital_dai,
>   				      ARRAY_SIZE(msm8916_wcd_digital_dai));
> +err_clk:
> +	clk_disable_unprepare(priv->ahbclk);
> +	return ret;
>   }
>   
>   static int msm8916_wcd_digital_remove(struct platform_device *pdev)

Hi,
I think that the same should be done for 'priv->mclk' if 
devm_snd_soc_register_component() returns an error.

Can you give it a look?

CJ
