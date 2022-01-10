Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EAC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jan 2022 15:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiAJPwg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jan 2022 10:52:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38638 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiAJPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:52:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A31E21F43333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829953;
        bh=FD4OrOm4vEUu599uP6rN4wBZHxBx3syC9RwGD2S/KAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LNSUbKQhjYkrgyJWNjXxgjJWH6iEnodHeDN3Lgsa8vZ9AoZ6DcjQ8MwS9BwF7BwxT
         fs7SRDq6wKfK2f7H/kEziA2X8NZqkqH5tYQWo6JaZUD7ap1/kpwQKK/NY1UKtJo7cN
         2pvMq5P17FhCEBdjeO0jB0X8K3hN8bnUD7WZEvUERrpGgQ/SyrVcL61H/Fat+YbUpa
         nmJbtqx+G4wkQS8RDulTUecqPUVW03OsNqhMSBnfsv9l68pYSmIj4r21Ri6ox/nxK7
         wAQrVweoifjJV6YDJe67TaEpANuAObJmiFrt5WPBJvjx5RRv9shrTS2tELyYfDIYkh
         WVnvc4GPkASQw==
Subject: Re: [v1 02/16] clk: mediatek: Add dt-bindings of MT8186 clocks
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
 <20220110134416.5191-3-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1254b48a-8aca-b791-a352-3aad9135d0b0@collabora.com>
Date:   Mon, 10 Jan 2022 16:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-3-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 clock dt-bindings, includes topckgen, apmixedsys,
> infracfg_ao, mcusys and subsystem clocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Hello Chun-Jie,

I think that this patch should be squashed with patch 01/16, as this
is dt-bindings as much as the yaml that you're introducing.

Regards,
- Angelo
