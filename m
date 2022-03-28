Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 14:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiC1PBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiC1PBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:01:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069AD26AD0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:59:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22SCt7aS027219;
        Mon, 28 Mar 2022 09:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aTdabDc+MOUdf3dcfIPD18QE7B9eZZWrMQsMy8IrLEA=;
 b=mRnqt+0J9RX1kK+IkIS2GVbPMdf/Vj6JfdmUF7tGpwBOH7q+6/gF9LsdQ+soa+dYbirz
 rkAWaZRnMw69M5UNEId4j/Ow2F6lg3QJ+eS/W0wBosTPKrIhWgt46x48K9TGUndSDswG
 WoWl79Fh2ziKa5iI5qGCsr0WkdoQuLjHWadCfoB0703rVjeJlPZfYvjdG/qwF4r9PDsz
 D+wzROb5DxnTK/R6bKNPlcB6lHhYGDG5G3Bv1Sj7WNLugCIKKqSVKahvFrjoOMouC3bm
 8IeYP5GfkayAsz/oefjL7+ENk1obrfAmJKt80ShR8xPGDjX4b8GvCx7+WsqnMS8x8DS6 Pg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081axr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 09:59:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 15:59:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 15:59:17 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 58C07B16;
        Mon, 28 Mar 2022 14:59:17 +0000 (UTC)
Date:   Mon, 28 Mar 2022 14:59:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jonathan Bakker <xc-racer2@live.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regulator: wm8994: Add an off-on delay for WM8994
 variant
Message-ID: <20220328145917.GJ38351@ediswmail.ad.cirrus.com>
References: <YkDpozx+ZmSWwwH0@sirena.org.uk>
 <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220328131132.GI38351@ediswmail.ad.cirrus.com>
 <YkHIBXixM1rERxqg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YkHIBXixM1rERxqg@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: xNp4kDYXu-uo4vNpiXkEe61_8BHXPpTY
X-Proofpoint-GUID: xNp4kDYXu-uo4vNpiXkEe61_8BHXPpTY
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:36:53PM +0100, Mark Brown wrote:
> On Mon, Mar 28, 2022 at 01:11:32PM +0000, Charles Keepax wrote:
> 
> > Part of me wonders if we should just apply it to 1811 and 8958
> > anyway, I suspect they have the same IP for the LDO and its just
> > the datasheets never got updated. I had a go chasing the apps guys
> > here but we are a little short on people who remember details of
> > these parts. So I guess we trust the datasheets for now, unless
> > you have any strong feelings, Mark?
> 
> With something like this the on/off time may be a requirement of the
> thing being powered rather than the regulator, the device might see
> enough power loss to confuse state but not trip the power on reset.

Aye a good point. I am certainly happy to stick with trusting the
datasheets here.

Thanks,
Charles
