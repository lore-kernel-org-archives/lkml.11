Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 07:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiE3HIK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiE3HIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:08:00 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922CB7FA;
        Mon, 30 May 2022 00:07:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 463541C0BB0; Mon, 30 May 2022 09:07:39 +0200 (CEST)
Date:   Mon, 30 May 2022 09:07:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alec Su <ae40515@yahoo.com.tw>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
Subject: Re: [PATCH v3 0/2] Add support for Xiaomi Mi 5s Plus
Message-ID: <20220530070738.GI1363@bug>
References: <20220520120449.12996-1-ae40515.ref@yahoo.com.tw>
 <20220520120449.12996-1-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220520120449.12996-1-ae40515@yahoo.com.tw>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This series adds the device tree for Xiaomi Mi 5s Plus (xiaomi-natrium)
> smartphone which is based on Snapdragon 821 SoC.

Please cc phone-devel@ mailing list with phone-related patches.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
