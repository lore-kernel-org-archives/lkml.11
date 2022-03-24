Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB56C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiCXHeZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348698AbiCXHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:33:51 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB6E99EE4;
        Thu, 24 Mar 2022 00:32:14 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:35082.2361266
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id A44201002A8;
        Thu, 24 Mar 2022 15:32:03 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id a2f8b1704e0a4b46bd8d83d638ee28cd for robh@kernel.org;
        Thu, 24 Mar 2022 15:32:13 CST
X-Transaction-ID: a2f8b1704e0a4b46bd8d83d638ee28cd
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <2aa26f44-38aa-4b3c-ccc3-0956a2ab5d77@189.cn>
Date:   Thu, 24 Mar 2022 15:32:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 7/7] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/23 04:49, Rob Herring wrote:
>> +	}
>> +
>> +	spin_lock_init(&li2c->reglock);
>> +
>> +	snprintf(compat, sizeof(compat), "lsdc,i2c-gpio-%d", index);
> compatible values shouldn't have an index and you shouldn't need a
> index in DT. You need to iterate over child nodes with matching
> compatible.

Why compatible values shouldn't have an index, does devicetree
specification prohibit this? [1]

The recommended format is "manufacturer,model", where manufacturer is a string describing the name
of the manufacturer (such as a stock ticker symbol), and model specifies the model number. [1]

[1] https://www.devicetree.org/specifications/

