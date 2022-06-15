Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8387CCA473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 19:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbiFOTzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350213AbiFOTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDD2983E;
        Wed, 15 Jun 2022 12:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2973D612FD;
        Wed, 15 Jun 2022 19:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7994AC34115;
        Wed, 15 Jun 2022 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322952;
        bh=L1IfRrjwmFboG0YuyIVj9iLYd93QBE3lTZ/YkDGWoHM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gGSKM7O2QDGx3l7MGUBs7sH+l1deXBKuVQOwbrTI36exqbP+0u6XN3C3yzIbDK19/
         rXbCjb41RjrPlXiKaq/PMIww7PA0AxkrO/kCCycuiZNlnAdiHM4t6Xi+UOzyuI8b21
         mIOZj184g/JjdISYgt0SP0TkF53esvQrkyuHjz8V9yA/aplB6kHSebs99Npyrp7jG0
         mtqxlrJ+/iFMrfPazFr6z+g5PZfWl+lDYtgj0U9krvYxhisC7A41hDuwRUc9razSLI
         jV/kPcO+FeJnPYwBOAGZSqNvqN2/yUi7UZecEreQmYvnwaWvDsDLltHsLa+9bHqTWp
         IhIbyqoCjDw9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220614153306.29339-4-quic_tdas@quicinc.com>
References: <20220614153306.29339-1-quic_tdas@quicinc.com> <20220614153306.29339-4-quic_tdas@quicinc.com>
Subject: Re: [PATCH v5 3/3] clk: qcom: lpass: Add support for resets & external mclk for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <quic_tdas@quicinc.com>, mka@chromium.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:55:50 -0700
User-Agent: alot/0.10
Message-Id: <20220615195552.7994AC34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-06-14 08:33:06)
> The clock gating control for TX/RX/WSA core bus clocks would be required
> to be reset(moved from hardware control) from audio core driver. Thus
> add the support for the reset clocks.

Why can't this driver remove the clks from hardware control when it
probes? Does something put the clks into hardware control mode at
runtime?
