Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9546CECAAD4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 17:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiHaRji (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiHaRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45BD9E97;
        Wed, 31 Aug 2022 10:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDBDB82012;
        Wed, 31 Aug 2022 17:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9D3C433D7;
        Wed, 31 Aug 2022 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967557;
        bh=21/jXoc9pOaesvAF2pNU0l9u10jC97xrRY8XVWHuY2c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rabg/dSH/ml8Q2d+0yo5kRybMYC8W//dfdK1zu4D4Kb49r2Ocku5T22e5FSJQwomV
         cmsnlAhTxINXLaM8ubni+67TVj2bW0Ks4ueiZUm5nroKDpdeuFBM5cYCVeV/2EFXJ4
         mFjGoaqqLp2YKTHGQJj21XZ7SwaMwxkVFXZi7JOBV11gn6zBwhX3iUXZohJEJRdVUl
         wEmxy+SsvIFXKvIegLIGLXMpqy4IEH4lV1JLuqfqZHF1N4HXcdaIfKy9mgDlyB7X3M
         fLRSnD/Z/co9lQeVqi6nbuY4CweVBnHbPFWcl7BLuCo+Y9v0oTip7dohhob5phxQQA
         v1ztOd9Zno6Yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-2-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-2-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 01/10] spmi: pmic-arb: add a print in cleanup_irq
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:39:15 -0700
User-Agent: alot/0.10
Message-Id: <20220831173917.4C9D3C433D7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:37)
> From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
>=20
> The cleanup_irq() was meant to clear and mask interrupts that were
> left enabled in the hardware but there was no interrupt handler
> registered for it. Add an error print when it gets invoked.
>=20
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
