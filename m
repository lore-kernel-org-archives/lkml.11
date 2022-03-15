Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7002C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiCONUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiCONU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:20:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A53BA4C;
        Tue, 15 Mar 2022 06:19:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1276C1F43FB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647350354;
        bh=KBc4Aujoo1XQDCjrBFgZKWdDskak3aNfGrunHc/KcHI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BteBlx9Save0tBUDlrZL+Dhk/GRQ/FhCA0YV7AJ81xpeUyW/s2lgLiGa0w56eF/zm
         Fhab1w7mm0Syq/1Q+S9Ug7SbhsKwGOnxG5bbaz5uqplp8SUewnXhPrN5RBowPIdipi
         Wmj+aZLoCAy7UlIgpaJrsnNSzQdLINFJQqeQ8FJKfbbVwECvqRIzN8wdkQEwjd/3FT
         5ERI6uXHaA1EizH8LhgcP9J7swA0d6cKuWglRHWYJiONRxzT/p9OeiyAjXg1EmCoHt
         FRJBxkMspgCbHtMBVu1nxChP/UP4EUzUJFYmLWGiJGQKUe9V2VSWRN0SLK9T4liAuW
         O4/ZL+7Kl3F9w==
Message-ID: <8aa94e65-0a3c-47dc-44d2-60d5dc996cf0@collabora.com>
Date:   Tue, 15 Mar 2022 14:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 10/19] ASoC: mediatek: mt8186: support tdm in platform driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>, robh+dt@kernel.org,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-11-jiaxin.yu@mediatek.com>
 <3c7c6e67-072c-6377-05bd-1b5baa579666@collabora.com>
 <YjCRZTu8AkYI0JVR@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YjCRZTu8AkYI0JVR@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 14:15, Mark Brown ha scritto:
> On Mon, Mar 14, 2022 at 11:39:11AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 13/03/22 16:10, Jiaxin Yu ha scritto:
>>> Add mt8186 tdm dai driver.
>>>
>>> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
>>> ---
>>>    sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 695 +++++++++++++++++++++
>>>    1 file changed, 695 insertions(+)
>>>    create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
>>>
>>> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
> 
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.


I'm sorry Mark, I usually do that, but this time it appears that for
some reason I forgot to delete the context on top of my reply, and ended
up deleting only the one on the bottom of it.

I'll pay more attention to that next time.
Sorry again.
