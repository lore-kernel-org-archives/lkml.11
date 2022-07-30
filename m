Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D011C19F2B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 08:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiG3I0I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jul 2022 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiG3I0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:26:07 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B413D3E;
        Sat, 30 Jul 2022 01:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659169507; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ikFsdtZS6QLQV7wSSuu0bVueSxmcxFv4Ze50nTcsSkhess3qh89zI+TmWNjMcLW86AI2LwysHmW7RQq6MJNwpOHiP1ONXDHPzsenibLgQxwwPN673VoyNXPAe6mbpKhIBiDOdyg4sfOj1lqKyfGSerWQtK9vdHGgY1ZqgekU5pQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1659169507; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=36su4m2QjNQHBx4LFEg5D6awN/f2ZqxlK1cfInLaW0k=; 
        b=LTCvyeBRkbu3CLzAff9ttLUsmCMQsvoDNcufIv9Rtn4To6xBcbPtDszYiF3USHSJ5T8xxiTTHISRXzHqYJT1mnUeIfGvcAET4Q6hRTNE5hShs50DuuNPvqrwqGccxxF6U98o83Wv+RAohOTxETHb8d2h4GNZKVeHSVb8klYXS0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659169507;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=36su4m2QjNQHBx4LFEg5D6awN/f2ZqxlK1cfInLaW0k=;
        b=Eg/bfs6AKyEGW9uenYU81ZDZ2AxVkJJst7BH4RJuWUWJT6zhKVwpFEIUCqGJjpmn
        VHX4b9gpExL9P6bajvIuCskR1KkHu1T5GrTc3ECJoNbdTJSg5EKkS4GkabBOWOpEgNF
        TuYbWsVoKDV84qcNu3xg9e5Fg+P1pIVpGrXjSKIo=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 165916950613718.65544541820657; Sat, 30 Jul 2022 01:25:06 -0700 (PDT)
Message-ID: <a2dd1ce2-a23e-8894-5ef4-b73ef0dad89d@arinc9.com>
Date:   Sat, 30 Jul 2022 11:24:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH net-next] dt-bindings: net: dsa: mediatek,mt7530:
 completely rework binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726122406.31043-1-arinc.unal@arinc9.com>
 <a8c778db-f52c-45cb-c671-556b24f3cb46@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <a8c778db-f52c-45cb-c671-556b24f3cb46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 27.07.2022 13:29, Krzysztof Kozlowski wrote:
> On 26/07/2022 14:24, Arınç ÜNAL wrote:
>> Completely rework the binding for MediaTek MT7530 and MT7531 switches.
> 
> Rules are the same for schema as for driver - one patch, one thing. You
> mix here trivial style changes (removal of quotes) with functional stuff.
> 
> Patch is unreviewable, so it must be split.

Thank you. I'm going to split it this way:
- Trivial changes; fix title and property descriptions, remove quotes, 
add me as maintainer, etc.
- Update binding description
- Update json-schema for compatible devices
- Update examples

Let me know if you have any objections.

Arınç
