Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70BBC19F21
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiG0VA1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiG0VAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:00:23 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2F1139;
        Wed, 27 Jul 2022 14:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658955568; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cQajrAiz3rDr2BA/813BS4ZEtvJ3H51uYD1ChgH8JgV0Ut70TcWoWXH2VWRdMzBhJGVt/xx2z5n5heN4eptpX61WlCjVlD2YO3VRWGqjA7CB7x4xYNnPT2E8xiSvbo7DU/fT6xmCF/PYADlJ33yVMvRdD34SPl2lWvnIUON6f8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658955568; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=npXsY1wOzM+2ZXYU371FlETSFcM+AsawUkMJLZdIO1A=; 
        b=RdBLoF26NZX1Vxp01BaQlhtUdKGMXh78OF56opnmTfOa0ijY0pBfiwwR56ZrSGiBcuvpuYFTPPOL4KTo2PFuLcCbZ8VgcNL9Zu+OnfMp+LBAtAgDv5hJ4wn0MXGjl7paNFKHk1hj0vci6X8qiCAiKp6sCZX2jzsLe5PKiZiauDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658955568;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=npXsY1wOzM+2ZXYU371FlETSFcM+AsawUkMJLZdIO1A=;
        b=OkqetZ05VtzEqYvDBoY2o/u5osK1xYce8774XN8MsMqGd4rCYHMFZ1eopk+juhis
        dfFH5PnU4MNhj+S7Vv5PPKyLhl/A/H5HT8uEj/q5nI6YhXtZ7O/w7gcJgNMgBRdl+dq
        yJQ+MHMIu2aJC30jamSJPInDUnfih1aKhezUHHaM=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1658955564512750.4742522224943; Wed, 27 Jul 2022 13:59:24 -0700 (PDT)
Message-ID: <f8ccb632-4bca-486b-a8a4-65b6b90de751@arinc9.com>
Date:   Wed, 27 Jul 2022 23:59:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Aw: [RFC PATCH net-next] dt-bindings: net: dsa: mediatek,mt7530:
 completely rework binding
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726122406.31043-1-arinc.unal@arinc9.com>
 <trinity-96b64414-7b29-4886-b309-48fc9f108959-1658953872981@3c-app-gmx-bs42>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-96b64414-7b29-4886-b309-48fc9f108959-1658953872981@3c-app-gmx-bs42>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.2022 23:31, Frank Wunderlich wrote:
> 
>> Gesendet: Dienstag, 26. Juli 2022 um 14:24 Uhr
>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
> 
> Hi,
> 
>> To Frank:
>> Let me know if MII bindings for port 5 and 6 on MT7531 are okay.
> 
> I ack krzysztof, that the change is really huge and it is hard to understand what exactly is changed and why. So please split. I have converted
> it to yaml, but not have changed the logic itself. I guess you know the switch better than me.
> 
>> Does your recent patch for MT7531 make it possible to set any port for CPU,
>> including user ports? For now, I put a rule to restrict CPU ports to 5 and
>> 6, as described on the description of dsa port reg property.
> 
> i only know that port 5 and 6 are possible, not about the other ports. Afair there was a check if port 5 or 6 (followed by available modes
> like rgmii, trgmii or sgmii) and then allow cpu-port-mode else allow only user-port mode. Had not changed this, so currently only these 2
> ports can be used as CPU.
> 
>> I suppose your patch does not bring support for using MT7530's port 5 as
>> CPU port. We could try this on a BPI-R2. Device schematics show that
>> MT7530's GMII pins are wired to GMAC1 of MT7623NI to work as RGMII.
> 
> my patches (and the version from Vladimir that was merged) only solves the Problem that CPU-Port was fixed to 6 before. I tested Patches on r2
> (mt7530) and r64 too (mt7531) that they do not break anything. But i have not disabled port 6 (maybe i had to do so for a port5-only mode), only
> enabled port 5 too and run iperf3 over a vlan-aware bridge between wan-port and port 5.

I've seen this under mt7530_setup():
The bit for MHWTRAP_P6_DIS is cleared to enable port 6 with the comment 
"Enable Port 6 only; P5 as GMAC5 which currently is not supported".

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/dsa/mt7530.c#n2189

I'm slowly learning C programming so I can't currently manage to do 
something on my own here, just letting you know.

Arınç
