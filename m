Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACBC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiDNJN6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbiDNJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:13:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701A3DA79
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:10:39 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 474E92223A;
        Thu, 14 Apr 2022 11:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649927437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wgg1H9lvOl/NupTcWnhuOCgNVzdve1fEQn32K1KCViQ=;
        b=vtDL8URxi64KhtUuf/UjZoXii8+NTzHgtbxvStWtgqf9qZXCkqNdWv1ex/0swKQYArA7mA
        Sl6OijxFa+BNsQHWuQemjix4d80l1XjnGVVr7NvHuipqSFqv8pAcRS6C+AxD4SS9FiANHJ
        SvmRPAjz63e+L/+m1meCq1f4ttK1u1E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Apr 2022 11:10:37 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: Update name and description of the
 set_4byte_addr_mode BFPT methods
In-Reply-To: <20220411125346.118274-3-tudor.ambarus@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-3-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0a751281376b564693aeb6336193e86c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-11 14:53, schrieb Tudor Ambarus:
> BFPT defines some standard methods to enter and exit the 4-Byte Address
> Mode. Use generic names for these methods and update their description.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Maybe we should mention which method is typically used by which
vendor in the function doc.

Reviewed-by: Michael Walle <michael@walle.cc>
