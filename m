Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9558AECAAD5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 03:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiH3D1H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 23:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiH3D0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:26:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1186FC5;
        Mon, 29 Aug 2022 20:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36433B81622;
        Tue, 30 Aug 2022 03:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B168C43144;
        Tue, 30 Aug 2022 03:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661830009;
        bh=qXAfX2O39p0xYnrj+PD1Oizsy6+IKu8PAhhax/9rYvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjLn74zKn6g5PJmghlBPKNE5Bdb2uypGkf9jfP3CvraMXHwhNHO1uH2QVvRMGHmlw
         D9KgH1c08TPhuWGoEDjrddYuKjTltvCGJsERz9Q+Zrh2LKr5Bvpb5Nlp+/3TtBxSC3
         2Z2On63KU0VJ0wwwAIbTt0wkradVNof4J8c2dXhn/uyKTGh5AQMAQ0pitoY6XWlMIX
         MmX4Anz3JTVsaC/zrNDJwa9h/TDIp9SAEs4vr70OU0hEs0T/89CjjQJ6El5yXCgs1h
         DIJyC7yRUaMummQ3U6e8TBcDaG2wonOeaXVynr/3H7klp+2StP+Z/yVB5h9KniLpZL
         fDkBRyz0bUQUg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robdclark@gmail.com,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        freedreno@lists.freedesktop.org, quic_akhilpo@quicinc.com
Cc:     krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update gpu opp table
Date:   Mon, 29 Aug 2022 22:26:45 -0500
Message-Id: <166182996517.340873.17873007815467520358.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829011035.1.Ie3564662150e038571b7e2779cac7229191cf3bf@changeid>
References: <20220829011035.1.Ie3564662150e038571b7e2779cac7229191cf3bf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 01:10:55 +0530, Akhil P Oommen wrote:
> On the lite sku where GPU Fmax is 550Mhz, voting for a slightly higher
> bandwidth at the highest gpu opp helps to improve "Manhattan offscreen"
> score by 10%. Update the gpu opp table such that this is applicable only
> on SKUs which has 550Mhz as GPU Fmax.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Update gpu opp table
      commit: ad3b0f33fa54b472d11169c1f0ada1b1d0ca5c6f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
