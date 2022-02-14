Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 22:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiBNWEj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 17:04:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiBNWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:04:33 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022ED1B4468
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:04:24 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21EIxpqg099035;
        Mon, 14 Feb 2022 12:59:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644865191;
        bh=Pz4wP+n3GDnd5dYw+LjYNjLY5RV4YQxdOk9eQvqnJ04=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MNDzLqntzEgbm5a6KaOg1vVjSfRpGrC5z+5F3pu4eTtQ6wQzESXxGKTAp7R3N5QRv
         uw1I+f/h3UlZl58Xl7gLbi5O6dxprmdCds8U1zbRnzqE9bnbEAjLxLGGD6WFkniOuB
         4vrz4t8xGB1yRy/nJ9W4ZE2yfxpw/a/5t80GoF9I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21EIxo3R013282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Feb 2022 12:59:51 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 14
 Feb 2022 12:59:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 14 Feb 2022 12:59:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21EIxnaE103038;
        Mon, 14 Feb 2022 12:59:50 -0600
Date:   Tue, 15 Feb 2022 00:29:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v1 11/14] mtd: spi-nor: spansion: slightly rework control
 flow in late_init()
Message-ID: <20220214185949.lp3jjifypaqyjenp@ti.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-12-michael@walle.cc>
 <f004399f-36b0-2099-b2a0-8ab0ecd114b7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f004399f-36b0-2099-b2a0-8ab0ecd114b7@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/22 03:26AM, Tudor.Ambarus@microchip.com wrote:
> On 2/2/22 16:58, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Increase readability of the code. Instead of returning early if the
> > flash size is smaller or equal than 16MiB and then do the fixups for
> > larger flashes, do it within the condition.
> > 
> 
> mm, no, I'm not sure this improves readability, I see the two equivalent.
> The original version has the benefit of no indentation. Pratyush?

I am fine with both to be honest. But Michael's reasoning does make some 
sense to me. So,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
