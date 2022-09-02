Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9467C54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 06:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiIBGjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiIBGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:39:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ED6BB690;
        Thu,  1 Sep 2022 23:39:36 -0700 (PDT)
X-UUID: 6af7e1f3cd024e96badef242daa60277-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=m70ifUKfsROMC77D6MINT4jBGjUL1IGdM1yLkcaO2/4=;
        b=QI6KSHGgVcpa/szzu3UPw3t3rXqjk8Xvn4pzSW+gfja2rAzJnzE+I6UPe30IabX+kTcucV/tCMnajIOWsYchJujDwZ9/da3OF9qR30Qm2AyzdNLpiuKlPFXAs7SCAJoO+dBgyludUuCd5AK8eaQBs4Y3erNcKzEbwL6NllO+Bws=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:38e55a4e-dbd2-4477-8c24-0bbfc925ba99,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:c224eb20-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6af7e1f3cd024e96badef242daa60277-20220902
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1070473871; Fri, 02 Sep 2022 14:39:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 2 Sep 2022 14:39:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Sep 2022 14:39:27 +0800
Message-ID: <1773eadbc41a6e4e1dd8a3ace213e51974e2fcbd.camel@mediatek.com>
Subject: Re: [PATCH 0/4] Introduce MediaTek frequency hopping driver
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 2 Sep 2022 14:39:27 +0800
In-Reply-To: <330d1f46-0e3c-f58e-b916-9e8644e7b4a1@linaro.org>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
         <330d1f46-0e3c-f58e-b916-9e8644e7b4a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 16:20 +0300, Krzysztof Kozlowski wrote:
> On 31/08/2022 15:48, Johnson Wang wrote:
> > Introduce MediaTek frequency hopping and spread spectrum clocking
> > control
> > for MT8186.
> 
> With one line introduction, you do not help us to understand this. :(
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Ok, I will describe more in the next version.

BRs,
Johnson Wang

