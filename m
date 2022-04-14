Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiDNIkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiDNIkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:40:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF363535
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:38:04 -0700 (PDT)
X-UUID: 8cce995ca1594bbd84835c6af7d68581-20220414
X-UUID: 8cce995ca1594bbd84835c6af7d68581-20220414
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 956665497; Thu, 14 Apr 2022 16:37:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 16:37:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 16:37:58 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <perex@perex.cz>,
        <rdunlap@infradead.org>, <tiwai@suse.com>
Subject: Re: [PATCH -next] sound/oss/dmasound: fix 'dmasound_setup' defined but not used
Date:   Thu, 14 Apr 2022 16:37:58 +0800
Message-ID: <20220414083758.32396-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <s5hzgko3wh5.wl-tiwai@suse.de>
References: <s5hzgko3wh5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> This must be a side-effect of the recent fix 9dd7c46346ca
> ("sound/oss/dmasound: fix build when drivers are mixed =y/=m").
> Adding Randy to Cc.
> 
> IMO, a less uglier way would be to add __maybe_unused to that
> function.  But it's a matter of taste.

thanks, I will use __maybe_unused and the fix tag in v2.

Thanks,
Miles

> 
> 
> thanks,
> 
> Takashi
