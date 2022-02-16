Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07944C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 13:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiBPNfL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:35:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBPNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:35:09 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF6842AB512;
        Wed, 16 Feb 2022 05:34:55 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:45428.1421487662
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 7E6A6100204;
        Wed, 16 Feb 2022 21:34:50 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 8d768eae87b04679bd18d891250ceade for maxime@cerno.tech;
        Wed, 16 Feb 2022 21:34:53 CST
X-Transaction-ID: 8d768eae87b04679bd18d891250ceade
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <965ca520-229f-5729-bf06-ae64ed3af383@189.cn>
Date:   Wed, 16 Feb 2022 21:34:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
 <20220209084908.kub4bs64rzhvpvon@houat>
 <84bfb2fc-595c-3bae-e8a0-c19ccbcfcfd8@189.cn>
 <20220209161624.42ijbnhanaaari46@houat>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20220209161624.42ijbnhanaaari46@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/10 00:16, Maxime Ripard wrote:
> And, to reinstate, we already have a mechanism to set an EDID, and if it
> wasn't an option, the DT is not the place to store an EDID blob.

Hi,


if DT is not the place to store EDID blob, why nvidia can do that ?

output->edid = of_get_property(output->of_node, "nvidia,edid", &size); 
[1][2]


[1] ./drivers/gpu/drm/tegra/output.c

[2] 
https://docs.nvidia.com/drive/active/5.0.10.3L/nvvib_docs/index.html#page/NVIDIA%20DRIVE%20Linux%20SDK%20Development%20Guide/Appendix/AppendixDeviceTree.html


