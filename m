Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82170C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 17:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351589AbiEQRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiEQRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:45:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C534EDD4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:45:39 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr1GK-0003Xu-C6; Tue, 17 May 2022 19:45:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] soc: rockchip: Fix refcount leak in rockchip_grf_init
Date:   Tue, 17 May 2022 19:45:34 +0200
Message-Id: <165280952595.3113166.2509300096908076477.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516072013.19731-1-linmq006@gmail.com>
References: <20220516072013.19731-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 11:20:10 +0400, Miaoqian Lin wrote:
> of_find_matching_node_and_match returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.

Applied, thanks!

[1/1] soc: rockchip: Fix refcount leak in rockchip_grf_init
      commit: 9b59588d8be91c96bfb0371e912ceb4f16315dbf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
