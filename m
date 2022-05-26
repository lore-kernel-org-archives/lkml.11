Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D993C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 09:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiEZJIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiEZJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:08:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8E1CB22
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:08:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q7r2gR028028;
        Thu, 26 May 2022 04:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Z2u2Lk+tAs74MurrL1ex/xUcRONdLT9NnnbB3xG2B1M=;
 b=LCzWrnhOWjYlaKGYKOlpKnOmjs4V62RRGPV2PhRSyYYnpuPx1RS3K2QZoNWz1t9dYKNd
 5C16Z2RRyaZlNM361Z3OZGUjiDJddAU0fQHRIcO/OCGkBHNc4FtCjMc/uzBsSFetMnzS
 I+atuQTq8ie/liUCl6iErly8MkFsK5+jt91sLJ18JvIj6bxlZLR0IiCYfhytT3jtIpd1
 bPLE11ZGuhHY8J65mrmpdk5MM7Jeb0GfjnwKUDkbhsynF30h6CKZpyfgOLsyI9iKFEvX
 ey88ShzYYvGdNfIwutFPIMJktQ5lyQS6zvC5IlfRepBt+YO/zmUPQWP2d8jTvKEdtBUf +Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u21y2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 May 2022 04:08:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 10:08:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 26 May 2022 10:08:19 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0994746C;
        Thu, 26 May 2022 09:08:18 +0000 (UTC)
Date:   Thu, 26 May 2022 09:08:18 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v4 10/17] ASoC: cs35l41: Do not print error when waking
 from hibernation
Message-ID: <20220526090818.GO38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <20220525131638.5512-11-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220525131638.5512-11-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: lAkdgHaKIOTlEOdFcdMB8dirDLAyOAGx
X-Proofpoint-GUID: lAkdgHaKIOTlEOdFcdMB8dirDLAyOAGx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:16:31PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> When waking from hibernation, it is possible for the function
> which sends the wake command to fail initially, but after a
> retry it will succeed. There is no need to print an error if
> the initial attempts fail.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
