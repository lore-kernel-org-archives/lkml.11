Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDEFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 10:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiCDKRg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiCDKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:17:30 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5FC1A94BE;
        Fri,  4 Mar 2022 02:16:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2245CAnk021576;
        Fri, 4 Mar 2022 04:15:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=khLSaYG6oS2lqdL3JueFC9e4ZvT4XthMfcFzydETK48=;
 b=I8pTkNF38ystB5H6Sd+YexpFBSTwNltDdlNtWyQVSMuUMsaAv2ke8aA69/oCd6tfc02h
 km5FpsSQ5e4bVaCk3UT7uEvKznWHT+o+fP1LJBy4WjvGioh9VtNc6YKKgoZ4ij73vTa2
 O3ZTTSxP3fbnDg5ktZpS+c0ErG2e6nHRt3uk9bT3F4bJfqHwHMuNKWEXCBK+/y059mLy
 6REhz44nasZYsm9aNNfOUvv+JYnt5U1lSSv0IizkBghRDJ0slnxmSAU5SBfAXIDtOvVI
 El+wCJP+q0pfs5B74z3K3E6wvCAbM2r6MM8Q7UYfryn7Dm2nhl8xp3q1zORPajfpFn2f KQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j1rskh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 04:15:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 10:15:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 10:15:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6D8A9B06;
        Fri,  4 Mar 2022 10:15:52 +0000 (UTC)
Date:   Fri, 4 Mar 2022 10:15:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/20] sound: cs35l41: Unify hardware configuration
Message-ID: <20220304101552.GA38351@ediswmail.ad.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-6-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303173059.269657-6-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 2R1OSoC0oB-He6_B6ZqpmKCrPkIXatxi
X-Proofpoint-ORIG-GUID: 2R1OSoC0oB-He6_B6ZqpmKCrPkIXatxi
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:30:44PM +0000, Lucas Tanure wrote:
> Both ASoC and HDA require to configure the GPIOs
> and Boost, so put that in single shared struct.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
