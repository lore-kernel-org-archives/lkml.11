Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B27C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 08:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiF2IaS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiF2IaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:30:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C13C714;
        Wed, 29 Jun 2022 01:30:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43B8D66018F1;
        Wed, 29 Jun 2022 09:30:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656491412;
        bh=k/GBrayqjumhXVKWOQr+XlgpEvOogSVYRcWj6cKD5Lk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UdlLwzKbbnVcC1GW8Bt2LO9bsJDdYIzHProVcOO4H3U2xFEbc7yph3W0WzowFvvGb
         7puOjny1P5Ih7ctJ/qoRX8G3GuogiDAJcKNCsLhdXR7coBqJ3nWZZM0cvAVRG6KhMF
         cyuAzw6gtvbt0H7uL1j9cCrukhclvND4IFtlM2uG6vKQX0z+1MD0lIbKEQKQ0V1dZZ
         UMkrMwokI2tIIQNpaMn5/jdUpItehgb1kBQw/IEwg3kbQB6N32A8jeOI30k3wV9Ic2
         Za/b5tKvv2K54ABmmCdb7csiCB/3CgOoBSKQoaU8wAVkXX0BPez1GHKzGNzx2/dLhU
         aT1VMU7AujulA==
Message-ID: <a94b6b57-3dcb-aac8-7920-351ec729bc4d@collabora.com>
Date:   Wed, 29 Jun 2022 10:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v11 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220627044331.2180641-1-xji@analogixsemi.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627044331.2180641-1-xji@analogixsemi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/22 06:43, Xin Ji ha scritto:
> USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> and a port controller (TCPC) - may require that the driver for the PD
> controller accesses directly also the on-chip port controller in some cases.
> 
> Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

