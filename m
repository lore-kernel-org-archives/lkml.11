Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiEIMvR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiEIMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:51:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32921C132
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:47:13 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2495nB4D024549;
        Mon, 9 May 2022 07:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=bOh5Ji8B4GU9h4s7zw/DlZwR/sozi0c8V7IoILKwY3M=;
 b=kNGL7WGUtufHa41XNhd94qqO+wiCXV6Y3l/jpJ+NJcqJjomHqrK0SWVKuPXktFjV3lfA
 Eo0IRCM+BFUioItu/uCBRFPfiLX5bU2Otk8s6LVvwFyfU/L0fOqbCsesXJLspNDUx+3r
 FKSOioXWISoU6Pct8Qo390zfRV6Hx4FBp4ri64ypsx9U9mvoaoV0WPTOANsO5mJ3DDmD
 S/YLgbmi7+XZKSevHJlSg8aKVQbJqAUfbvgw3QkUAc0ZjDVuGE382oy1nfUxjLLMeWXr
 3YJ/z8XwfN7uxNMGGSECZJns9l6kQk3pbOav8XTGyrcDWgHfb0bYLI37TCx0CLILhb7o 8g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6ntmxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 07:46:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 13:46:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 13:46:24 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE303B10;
        Mon,  9 May 2022 12:46:24 +0000 (UTC)
Date:   Mon, 9 May 2022 12:46:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <20220509124624.GY38351@ediswmail.ad.cirrus.com>
References: <20220509121055.31103-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509121055.31103-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: R1cmXhlaFtSl-FIBReia7xV4zkfsE-F7
X-Proofpoint-GUID: R1cmXhlaFtSl-FIBReia7xV4zkfsE-F7
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote:
> This adds devicetree support to the wm8940 codec driver.
> With a DT-based kernel, there is no board-specific setting
> to select the driver so allow it to be manually chosen.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
