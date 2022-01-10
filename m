Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2150C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jan 2022 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiAJPvH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jan 2022 10:51:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38614 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiAJPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:51:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8F5F51F43321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829865;
        bh=LjyJJ271iZCn/ccFFJ81ANCTkmRM1NPdpW0Gele44FQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QKA4CEexvrepIa2cBkR9+oqEjpYEeM8jeRV3jgGn96Sy6swAWLiU5s8HN5T6USgEu
         c1tbvu7116ugkSnvY5nJLsufkaCOlmqcEhOCg/NLKDxO9fev5yRQZiRcub21va+pHa
         wmkBVmx+nncNVwjj2VNx7gOJbkF+mmJez2Sn+6TM7+fhIsaRnogbLBt/Siyib5OK4c
         U/n+KkUe2GUsyJQUARJYkciJZNJw3woC+Sry5YXkfAQchU4u4xuLVQJ7dSTrSGCVs6
         vzTkQxo4AueYenGuivcHHSjw5hO8SKa6g6QJ69jSEuOtyu5voQ6N6wlDaZgTKEFvz8
         Y7R7vJg261yoA==
Subject: Re: [v1 03/16] clk: mediatek: Add MT8186 mcusys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
 <20220110134416.5191-4-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9f60fb73-0983-8c7f-f96b-ea625f644ea7@collabora.com>
Date:   Mon, 10 Jan 2022 16:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-4-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 mcusys clock controller which provides muxes
> to select the clock source of APMCU.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

