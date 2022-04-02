Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6104C433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 20:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiDBUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiDBUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:43:52 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765A5D1A4;
        Sat,  2 Apr 2022 13:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648932087; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cxCXJ5ZUtSYPG7vW7hSxEAccR9bEs2MbAtgJ+5IFb6WFeCswEzYACBoczyhED11heVpBmInFLZsL14riOJ8HunTGAL7kdPStjtr3PUMN+PpCKc4353SKoSBSkJW7VDrhyElLazCF/FvVvCgOpcox/dLazNaf3k+DnnNv/31eiYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648932087; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AI1CWy+vPCL4wJICPiReEnWqJXsxDqhOFVpnH4rLfIo=; 
        b=CvlrV2zE3EuZWh2q4DDrEVvNo+7QdbWglYHkkQpcOYLetZ02E5XanTvjJ6Jxi9U2ZB/Cvwx35Oc2CKiapbsCGRMTVSHNmv9/Qoy/+dc7EbkPBMQPB+SgOZtl3kES2jXTLQuup+fQOvaejRgZwwUxWtrEyJly8Sls0CXe9jbVsXA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648932087;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AI1CWy+vPCL4wJICPiReEnWqJXsxDqhOFVpnH4rLfIo=;
        b=kaEcM0BcaN7ZiPmSZoD3QvFbwweveaaN0nzDxEIWP09xOu4Zx6JMROjfGHGHqj9e
        7YPodsOHpBR82lEnJng4gw4SMkNKJeuNMy3wdTI8MOSxPgwFciUkHDqGHa+m3wl1Pfi
        Ju0JVnRwuItIC3H2KN27jxV2mi9OCEDv69gW/9A8=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648932083496229.1744985746061; Sat, 2 Apr 2022 13:41:23 -0700 (PDT)
Message-ID: <bf363c60-3432-7b98-97c5-0dbeddad8a4d@arinc9.com>
Date:   Sat, 2 Apr 2022 23:41:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm: fix BCM53012 and BCM53016 SoC
 strings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20220401172427.2806-1-arinc.unal@arinc9.com>
 <fbbd44cc-e839-9532-962a-538ce834930c@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <fbbd44cc-e839-9532-962a-538ce834930c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 19:28, Krzysztof Kozlowski wrote:
> On 01/04/2022 19:24, Arınç ÜNAL wrote:
>> Fix inaccurate SoC strings brcm,brcm53012 and brcm,brcm53016 to respectively
>> brcm,bcm53012 and brcm,bcm53016.
>>
>> Create a new description for BCM53016 and move Meraki MR32 under it.
>>
>> Fixes: 4cb5201fcb5d ("dt-bindings: arm: bcm: Convert BCM4708 to YAML")
>> Fixes: a2e385f5374d ("dt-bindings: ARM: add bindings for the Meraki MR32")
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>> brcm,bcm53012 string was silently changed to brcm,brcm53012 after
>> converting to YAML. Let me know if this was intentional.
>>
> 
> Thanks for your patch. This looks like 2 or 3 separate patches:
> 1. Correct meraki and BCM53016 bindings,
> 2. Rename brcm->bcm, in bindings,
> 3. Change DTS.

Will send v2, thanks.

Arınç
